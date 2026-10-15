-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labadkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labadkr_beta.labadkr_user_activity USING btree (asset_id, asset_type_id);


--
