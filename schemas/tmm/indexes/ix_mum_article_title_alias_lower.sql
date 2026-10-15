-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_article_title_alias_lower
-- Type: INDEX

-- Name: ix_mum_article_title_alias_lower; Type: INDEX; Schema: tmm; Owner: -
--

CREATE UNIQUE INDEX ix_mum_article_title_alias_lower ON tmm.tmm_article USING btree (lower((title_alias)::text));


--
