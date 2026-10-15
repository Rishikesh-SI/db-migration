-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_article_title
-- Type: INDEX

-- Name: ix_khi_article_title; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_article_title ON khi.khi_article USING btree (title);


--
