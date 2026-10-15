-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_user_activity_aid
-- Type: INDEX

-- Name: ix_pbl_user_activity_aid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_user_activity_aid ON pbl.pbl_user_activity USING btree (user_id);


--
