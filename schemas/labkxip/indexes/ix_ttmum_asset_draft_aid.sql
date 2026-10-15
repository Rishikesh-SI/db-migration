-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labkxip.labkxip_asset_draft USING btree (asset_id);


--
