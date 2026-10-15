-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labgmr_01082024.labgmr_user_activity USING btree (asset_id, asset_type_id);


--
