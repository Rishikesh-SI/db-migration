-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_article_title_alias_lower
-- Type: INDEX

-- Name: ix_hsl_article_title_alias_lower; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE UNIQUE INDEX ix_hsl_article_title_alias_lower ON labhsl.labhsl_article USING btree (lower((title_alias)::text));


--
