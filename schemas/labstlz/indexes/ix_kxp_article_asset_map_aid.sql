-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_article_asset_map_aid
-- Type: INDEX

-- Name: ix_kxp_article_asset_map_aid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_article_asset_map_aid ON labstlz.labstlz_article_asset_map USING btree (article_id);


--
