-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: ix_siwaf_sitemap_matches
-- Type: INDEX

-- Name: ix_siwaf_sitemap_matches; Type: INDEX; Schema: siwaf; Owner: -
--

CREATE INDEX ix_siwaf_sitemap_matches ON siwaf.siwaf_sitemap_matches USING btree (sitemap_match_id, client_code, match_id);


--
