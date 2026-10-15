-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_user_activity_aatid
-- Type: INDEX

-- Name: ix_user_activity_aatid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_user_activity_aatid ON swa.swa_user_activity USING btree (asset_id, asset_type_id);


--
