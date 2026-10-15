-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_article_title_alias_lower
-- Type: INDEX

-- Name: ix_hsl_article_title_alias_lower; Type: INDEX; Schema: hsl; Owner: -
--

CREATE UNIQUE INDEX ix_hsl_article_title_alias_lower ON hsl.hsl_article USING btree (lower((title_alias)::text));


--
