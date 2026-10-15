-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_article_title
-- Type: INDEX

-- Name: ix_spz_article_title; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_article_title ON spz.spz_article USING btree (title);


--
