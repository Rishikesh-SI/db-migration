-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_application_event_subscription_eid
-- Type: INDEX

-- Name: ix_gpn_application_event_subscription_eid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_application_event_subscription_eid ON gpn.gpn_application_event_subscription_map USING btree (event_id);


--
