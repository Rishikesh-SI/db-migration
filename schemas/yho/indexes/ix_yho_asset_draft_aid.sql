-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_asset_draft_aid
-- Type: INDEX

-- Name: ix_yho_asset_draft_aid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_asset_draft_aid ON yho.yho_asset_draft USING btree (asset_id);


--
