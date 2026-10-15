-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_article_created_date
-- Type: INDEX

-- Name: ix_khi_article_created_date; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_article_created_date ON khi.khi_article USING btree (created_date);


--
