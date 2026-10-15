-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_article_alias
-- Type: INDEX

-- Name: ix_swa_article_alias; Type: INDEX; Schema: swa; Owner: -
--

CREATE UNIQUE INDEX ix_swa_article_alias ON swa.swa_article USING btree (title_alias);


--
