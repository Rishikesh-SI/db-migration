-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_article_asset_map_aid
-- Type: INDEX

-- Name: ix_kxp_article_asset_map_aid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_article_asset_map_aid ON labkxp.labkxp_article_asset_map USING btree (article_id);


--
