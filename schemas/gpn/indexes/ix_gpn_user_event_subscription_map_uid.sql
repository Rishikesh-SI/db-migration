-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_user_event_subscription_map_uid
-- Type: INDEX

-- Name: ix_gpn_user_event_subscription_map_uid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_user_event_subscription_map_uid ON gpn.gpn_user_event_subscription_map USING btree (user_id);


--
