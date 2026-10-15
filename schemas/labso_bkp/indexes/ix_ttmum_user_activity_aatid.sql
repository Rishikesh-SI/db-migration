-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labso_bkp.labso_user_activity USING btree (asset_id, asset_type_id);


--
