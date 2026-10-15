-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_article_asset_map_aid
-- Type: INDEX

-- Name: ix_pkl_article_asset_map_aid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_article_asset_map_aid ON labpkl.labpkl_article_asset_map USING btree (article_id);


--
