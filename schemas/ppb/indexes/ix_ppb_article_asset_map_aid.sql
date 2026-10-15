-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ppb_article_asset_map_aid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_article_asset_map_aid ON ppb.ppb_article_asset_map USING btree (article_id);


--
