-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_asset_draft_aid
-- Type: INDEX

-- Name: ix_cfc_asset_draft_aid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_asset_draft_aid ON cfc.cfc_asset_draft USING btree (asset_id);


--
