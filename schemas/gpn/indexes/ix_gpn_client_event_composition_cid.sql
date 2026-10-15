-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_client_event_composition_cid
-- Type: INDEX

-- Name: ix_gpn_client_event_composition_cid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_client_event_composition_cid ON gpn.gpn_client_event_composition USING btree (client_id);


--
