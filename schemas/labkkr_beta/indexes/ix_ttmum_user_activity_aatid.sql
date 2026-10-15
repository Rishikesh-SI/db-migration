-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labkkr_beta.labkkr_user_activity USING btree (asset_id, asset_type_id);


--
