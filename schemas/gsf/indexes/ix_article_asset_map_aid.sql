-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_article_asset_map_aid
-- Type: INDEX

-- Name: ix_article_asset_map_aid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_article_asset_map_aid ON gsf.gsf_article_asset_map USING btree (article_id);


--
