-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_article_title
-- Type: INDEX

-- Name: ix_gsf_article_title; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_article_title ON gsf.gsf_article USING btree (title);


--
