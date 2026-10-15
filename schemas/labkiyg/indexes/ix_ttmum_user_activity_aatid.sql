-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labkiyg.labkiyg_user_activity USING btree (asset_id, asset_type_id);


--
