-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_article_asset_map_aid
-- Type: INDEX

-- Name: ix_pkl_article_asset_map_aid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_article_asset_map_aid ON pkl.pkl_article_asset_map USING btree (article_id);


--
