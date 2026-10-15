-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_article_title_alias_lower
-- Type: INDEX

-- Name: ix_mum_article_title_alias_lower; Type: INDEX; Schema: dhm; Owner: -
--

CREATE UNIQUE INDEX ix_mum_article_title_alias_lower ON dhm.dhm_article USING btree (lower((title_alias)::text));


--
