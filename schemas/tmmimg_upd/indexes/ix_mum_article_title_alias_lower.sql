-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_article_title_alias_lower
-- Type: INDEX

-- Name: ix_mum_article_title_alias_lower; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE UNIQUE INDEX ix_mum_article_title_alias_lower ON tmmimg_upd.tmmimg_upd_article USING btree (lower((title_alias)::text));


--
