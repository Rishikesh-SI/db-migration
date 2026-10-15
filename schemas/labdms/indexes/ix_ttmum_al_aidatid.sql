-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_ttmum_al_aidatid
-- Type: INDEX

-- Name: ix_ttmum_al_aidatid; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_ttmum_al_aidatid ON labdms.labdms_asset_list USING btree (asset_id, asset_type_id);


--
