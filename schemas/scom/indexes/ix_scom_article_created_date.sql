-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_article_created_date
-- Type: INDEX

-- Name: ix_scom_article_created_date; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_article_created_date ON scom.scom_article USING btree (created_date);


--
