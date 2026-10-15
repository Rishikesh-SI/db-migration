-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_article_title
-- Type: INDEX

-- Name: ix_upy_article_title; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_article_title ON upy.upy_article USING btree (title);


--
