-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_article_title_alias_lower
-- Type: INDEX

-- Name: ix_upp_article_title_alias_lower; Type: INDEX; Schema: utt; Owner: -
--

CREATE UNIQUE INDEX ix_upp_article_title_alias_lower ON utt.utt_article USING btree (lower((title_alias)::text));


--
