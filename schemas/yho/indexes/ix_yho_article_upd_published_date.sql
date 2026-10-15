-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_article_upd_published_date
-- Type: INDEX

-- Name: ix_yho_article_upd_published_date; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_article_upd_published_date ON ONLY yho.yho_article_upd USING btree (published_date DESC);


--
