-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_asset_draft_aid
-- Type: INDEX

-- Name: ix_kxp_asset_draft_aid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_asset_draft_aid ON labkxp.labkxp_asset_draft USING btree (asset_id);


--
