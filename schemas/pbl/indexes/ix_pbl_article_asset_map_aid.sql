-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_article_asset_map_aid
-- Type: INDEX

-- Name: ix_pbl_article_asset_map_aid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_article_asset_map_aid ON pbl.pbl_article_asset_map USING btree (article_id);


--
