-- The following trigger checks before the insertion or the update of the Card relation
-- if only one card associated to the customer related to the modification is enable.

CREATE FUNCTION checkEnabledCard() RETURNS TRIGGER AS $$
	BEGIN
		IF(NEW.enabled = TRUE) THEN
			-- Check if there is another card enabled with same customer_id
			PERFORM customer
				FROM mbt.Card
				WHERE customer = NEW.customer AND enabled = TRUE;
			IF FOUND THEN
				RAISE EXCEPTION 'Customer % already has an enabled card.', new.customer;
			END IF;
			RETURN NEW;
		ELSE
			-- Check if there is another card enabled with same customer value
			PERFORM customer
				FROM mbt.Card
				WHERE customer = NEW.customer AND enabled = TRUE AND card_id != new.card_id;
			IF FOUND THEN RETURN NEW;
			ELSE 
				NEW.enabled = TRUE;
				RETURN NEW;
			END IF;			
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER checkCard
	BEFORE INSERT OR UPDATE ON mbt.Card
	FOR EACH ROW
	EXECUTE PROCEDURE checkEnabledCard();
	
	
-- This trigger checks if the value of the attribute Type of the relation Subscription is consistent
-- with the duration type specified, in case of “daily” subscriptions Hours_duration must be NULL and Days_duration NOT NULL,
-- viceversa in case of “hourly” subscriptions the former must be NOT NULL and the latter NULL.

CREATE FUNCTION checkSubTypeDuration() RETURNS TRIGGER AS $$
	BEGIN
		IF (NEW.type = 'daily') THEN
			IF (NEW.days_duration IS NOT NULL AND NEW.hours_duration IS NULL) THEN
				RETURN NEW;
			ELSE
				RAISE EXCEPTION 'Subscriptions of type "daily" must have days_duration NOT NULL and hours_duration NULL';
			END IF;
		ELSIF (NEW.type = 'hourly') THEN
			IF (NEW.days_duration IS NULL AND NEW.hours_duration IS NOT NULL) THEN
				RETURN NEW;
			ELSE
				RAISE EXCEPTION 'Subscriptions of type "hourly" must have days_duration NULL and hours_duration NOT NULL';
			END IF;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER checkSubscription
	BEFORE INSERT OR UPDATE ON mbt.Subscription
	FOR EACH ROW
	EXECUTE PROCEDURE checkSubTypeDuration();