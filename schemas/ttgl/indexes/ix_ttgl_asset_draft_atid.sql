-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_asset_draft_atid
-- Type: INDEX

-- Name: ix_ttgl_asset_draft_atid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_asset_draft_atid ON ttgl.ttgl_asset_draft USING btree (asset_type_id);


--
