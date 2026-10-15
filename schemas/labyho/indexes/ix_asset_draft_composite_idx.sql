-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_asset_draft_composite_idx
-- Type: INDEX

-- Name: ix_asset_draft_composite_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_asset_draft_composite_idx ON labyho.labyho_asset_draft USING btree (asset_id, asset_type_id, version_number);


--
