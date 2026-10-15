-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labpcm.labpcm_user_activity USING btree (asset_id, asset_type_id);


--
