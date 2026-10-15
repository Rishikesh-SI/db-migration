-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_asset_draft_composite_idx
-- Type: INDEX

-- Name: ix_asset_draft_composite_idx; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_asset_draft_composite_idx ON labdms.labdms_asset_draft USING btree (asset_id, asset_type_id, version_number);


--
