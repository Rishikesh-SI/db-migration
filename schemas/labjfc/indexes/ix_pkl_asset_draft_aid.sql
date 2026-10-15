-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_asset_draft_aid
-- Type: INDEX

-- Name: ix_pkl_asset_draft_aid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_asset_draft_aid ON labjfc.labjfc_asset_draft USING btree (asset_id);


--
