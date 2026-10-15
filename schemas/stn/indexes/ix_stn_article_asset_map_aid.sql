-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_article_asset_map_aid
-- Type: INDEX

-- Name: ix_stn_article_asset_map_aid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_article_asset_map_aid ON stn.stn_article_asset_map USING btree (article_id);


--
