-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_article_title
-- Type: INDEX

-- Name: ix_scom_article_title; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_article_title ON scom.scom_article USING btree (title);


--
