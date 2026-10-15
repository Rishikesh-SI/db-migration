-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_article_title
-- Type: INDEX

-- Name: ix_tfa_article_title; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_article_title ON tfa.tfa_article USING btree (title);


--
