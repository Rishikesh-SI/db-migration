-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: ix_ttmum_asset_draft_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_atid; Type: INDEX; Schema: labos; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_atid ON labos.labos_asset_draft USING btree (asset_type_id);


--
