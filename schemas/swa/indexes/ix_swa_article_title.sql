-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_article_title
-- Type: INDEX

-- Name: ix_swa_article_title; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_article_title ON swa.swa_article USING btree (title);


--
