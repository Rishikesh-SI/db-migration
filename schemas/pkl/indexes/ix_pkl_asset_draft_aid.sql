-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_asset_draft_aid
-- Type: INDEX

-- Name: ix_pkl_asset_draft_aid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_asset_draft_aid ON pkl.pkl_asset_draft USING btree (asset_id);


--
