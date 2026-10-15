-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_article_title
-- Type: INDEX

-- Name: ix_dd_article_title; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_article_title ON dd.dd_article USING btree (title);


--
