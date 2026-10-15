-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_asset_draft_aid
-- Type: INDEX

-- Name: ix_mum_asset_draft_aid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_asset_draft_aid ON tmmimg_upd.tmmimg_upd_asset_draft USING btree (asset_id);


--
