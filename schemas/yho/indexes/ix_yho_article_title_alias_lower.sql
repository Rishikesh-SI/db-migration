-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_article_title_alias_lower
-- Type: INDEX

-- Name: ix_yho_article_title_alias_lower; Type: INDEX; Schema: yho; Owner: -
--

CREATE UNIQUE INDEX ix_yho_article_title_alias_lower ON yho.yho_article USING btree (lower((title_alias)::text));


--
