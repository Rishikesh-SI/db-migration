-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_client_event_image_eid
-- Type: INDEX

-- Name: ix_gpn_client_event_image_eid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_client_event_image_eid ON gpn.gpn_client_event_image USING btree (event_id);


--
