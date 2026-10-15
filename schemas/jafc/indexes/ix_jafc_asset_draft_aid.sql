-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_draft_aid
-- Type: INDEX

-- Name: ix_jafc_asset_draft_aid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_draft_aid ON jafc.jafc_asset_draft USING btree (asset_id);


--
