-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_article_title_alias_lower
-- Type: INDEX

-- Name: ix_swa_article_title_alias_lower; Type: INDEX; Schema: swa; Owner: -
--

CREATE UNIQUE INDEX ix_swa_article_title_alias_lower ON swa.swa_article USING btree (lower((title_alias)::text));


--
