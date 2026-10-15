-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_user_did
-- Type: INDEX

-- Name: ix_gpn_user_did; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_user_did ON gpn.gpn_user USING btree (device_id);


--
